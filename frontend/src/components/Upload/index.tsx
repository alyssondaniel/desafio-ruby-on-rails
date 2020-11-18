import React, { useCallback } from "react";
import { useDropzone } from "react-dropzone";
import { useFiles } from "../../context/files";
import { DropContainer, UploadMessage } from "./styles";
import { Link } from "react-router-dom";

function Upload() {
  const { handleUpload } = useFiles();

  const onDrop = useCallback(
    (files) => {
      handleUpload(files);
    },
    [handleUpload]
  );

  const {
    getRootProps,
    getInputProps,
    isDragActive,
    isDragReject,
  } = useDropzone({
    accept: [".txt"],
    onDrop,
  });

  const renderDragMessage = useCallback(() => {
    if (!isDragActive) {
      return <UploadMessage>Arraste os arquivos CNAB aqui...</UploadMessage>;
    }

    if (isDragReject) {
      return (
        <UploadMessage type="error">
          Tipo de arquivo não suportado
        </UploadMessage>
      );
    }

    return <UploadMessage type="success">Solte as imagens aqui</UploadMessage>;
  }, [isDragActive, isDragReject]);

  return (
    <>
      <DropContainer {...getRootProps()}>
        <input {...getInputProps()} />
        {renderDragMessage()}
      </DropContainer>
      <Link to="/listar">Listar</Link>
    </>
  );
}

export default Upload;