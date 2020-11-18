import React, {
  createContext,
  useState,
  useEffect,
  useCallback,
  useContext,
} from "react";
import { v4 as uuidv4 } from "uuid";
import filesize from "filesize";

import api from "../services/api";

export interface ITransaction {
  id: string,
  transaction_type_id: number,
  company_id: number,
  occurrence_at: string,
  amount: string,
  document: string,
  card_number: string,
  owner_name: string,
  type_code: number,
  type_description: string,
  type_way: string,
  type_signal_char: string,
  company_name: string,
  company_balance: string,
}
export interface ICompany {
  id: string,
  name: string,
  balance: string,
}
export interface IData {
  transactions: ITransaction[];
  company: ICompany;
}
export interface IFile {
  id: string;
  name: string;
  readableSize: string;
  preview: string;
  file: File | null;
  url: string;
  uploaded?: boolean;
  progress?: number;
  error?: boolean;
}

interface IFileContextData {
  uploadedFiles: IFile[];
  deleteFile(id: string): void;
  handleUpload(file: any): void;
}

const FileContext = createContext<IFileContextData>({} as IFileContextData);

const FileProvider: React.FC = ({ children }) => {
  const [uploadedFiles, setUploadedFiles] = useState<IFile[]>([]);

  useEffect(() => {
    api.get<IData>("api/v1/transactions").then((response) => {
      // const { transactions } = response.data;
      
      // const postFormatted: IFile[] = transactions.map((transaction) => {
      //   return {
      //     id: transaction.id,
      //     name: transaction.document,
      //     url: '',
      //     // preview: post.url,
      //     preview: '',
      //     // readableSize: filesize(post.size),
      //     readableSize: '',
      //     file: null,
      //     error: false,
      //     uploaded: true,
      //   };
      // });

      // setUploadedFiles(postFormatted);
      setUploadedFiles([]);
    });
  }, []);

  useEffect(() => {
    return () => {
      uploadedFiles.forEach((file) => URL.revokeObjectURL(file.preview));
    };
  });

  const updateFile = useCallback((id, data) => {
    setUploadedFiles((state) =>
      state.map((file) => (file.id === id ? { ...file, ...data } : file))
    );
  }, []);

  const processUpload = useCallback(
    (uploadedFile: IFile) => {
      const data = new FormData();
      if (uploadedFile.file) {
        data.append("transaction[file]", uploadedFile.file, uploadedFile.name);
      }

      api
        .post("/api/v1/transactions/upload", data, {
          onUploadProgress: (progressEvent) => {
            let progress: number = Math.round(
              (progressEvent.loaded * 100) / progressEvent.total
            );

            console.log(
              `A imagem ${uploadedFile.name} est√° ${progress}% carregada... `
            );

            updateFile(uploadedFile.id, { progress });
          },
        })
        .then((response) => {
          console.log(
            `A imagem ${uploadedFile.name} j√° foi enviada para o servidor!`
          );

          updateFile(uploadedFile.id, {
            uploaded: true,
            id: response.data._id,
            url: response.data.url,
          });
        })
        .catch((err) => {
          console.error(
            `Houve um problema para fazer upload da imagem ${uploadedFile.name} no servidor`
          );
          console.log(err);

          updateFile(uploadedFile.id, {
            error: true,
          });
        });
    },
    [updateFile]
  );

  const handleUpload = useCallback(
    (files: File[]) => {
      const newUploadedFiles: IFile[] = files.map((file: File) => ({
        file,
        id: uuidv4(),
        name: file.name,
        readableSize: filesize(file.size),
        preview: URL.createObjectURL(file),
        progress: 0,
        uploaded: false,
        error: false,
        url: "",
      }));

      // concat é mais performático que ...spread
      // https://www.malgol.com/how-to-merge-two-arrays-in-javascript/
      setUploadedFiles((state) => state.concat(newUploadedFiles));
      newUploadedFiles.forEach(processUpload);
    },
    [processUpload]
  );

  const deleteFile = useCallback((id: string) => {
    api.delete(`api/v1/transactions/${id}`);
    setUploadedFiles((state) => state.filter((file) => file.id !== id));
  }, []);

  return (
    <FileContext.Provider value={{ uploadedFiles, deleteFile, handleUpload }}>
      {children}
    </FileContext.Provider>
  );
};

function useFiles(): IFileContextData {
  const context = useContext(FileContext);

  if (!context) {
    throw new Error("useFiles must be used within FileProvider");
  }

  return context;
}

export { FileProvider, useFiles };