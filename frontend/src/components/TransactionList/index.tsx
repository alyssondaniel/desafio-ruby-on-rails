import React, { useEffect, useState } from 'react';
import api from '../../services/api'
import { IData, ITransaction, ICompany } from "../../context/files";
import { Link } from "react-router-dom";
import NumberFormat from 'react-number-format';
import moment from 'moment/moment';
import 'bootstrap/dist/css/bootstrap.min.css';

const TransactionList: React.FC = () => {
  const [transactionList, setTransactionList] = useState<ITransaction[]>([]);
  const [companyList, setCompanyList] = useState<ICompany[]>([]);
  const [selectedCompanyId, setSelectedCompanyId] = useState<String>('');
  const [company, setCompany] = useState<ICompany>();

  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>): Promise<void> => {
    e.preventDefault();
    let url = '/api/v1/transactions';
    if (selectedCompanyId.length)
      url = `/api/v1/transactions?filter[company_id]=${selectedCompanyId}`

    api
      .get<IData>(url)
      .then(response => {
        setTransactionList(response.data.transactions);
        setCompany(response.data.company);
      });
  }

  const handleChangeSelect = (e: React.ChangeEvent<HTMLSelectElement>) => {
    e.preventDefault();
    setSelectedCompanyId(e.target.value);
  }
  useEffect(() => {
    api.get<ICompany[]>('/api/v1/companies').then(
      response => setCompanyList(response.data)
    );
  }, []);

  return (
    <div className="container">
      <div className="card">
        <div className="card-body">
          <h5 className="card-title">
            <div className="d-flex justify-content-between">
              <form onSubmit={handleSubmit}>
                <div className="form-row align-items-center">
                  <div className="col-auto my-1">
                    <label className="mr-sm-2 sr-only" htmlFor="inlineFormCustomSelect">Preference</label>
                    <select
                      onChange={(e => handleChangeSelect(e))}
                      className="custom-select mr-sm-2"
                      id="inlineFormCustomSelect">
                      <option value=''>Todas as lojas</option>
                      {companyList.map(
                        (company: ICompany) => <option key={company.id} value={company.id}>{company.name}</option>
                      )}
                    </select>
                  </div>
                  <div className="col-auto my-1">
                    <button type="submit" className="btn btn-primary">Filtrar</button>
                  </div>
                </div>
              </form>
              <Link to="/">Enviar arquivo CNAB</Link>
            </div>
          </h5>
          <h6>Listando transações</h6>
          <table className="table table-hover table-sm">
            <thead>
              <tr>
                <th>Tipo</th>
                <th>Ocorrência</th>
                <th>Valor</th>
                <th>CPF</th>
                <th>Cartão</th>
                <th>Dono da loja</th>
                <th>Loja</th>
              </tr>
            </thead>
            {transactionList.map((transaction: ITransaction) => (
              <tbody key={transaction.id}>
                <tr>
                  <td>{transaction.type_description}</td>
                  <td>{moment(transaction.occurrence_at).format('DD/MM/YYYY HH:mm:ss')}</td>
                  <td className={transaction.type_signal_char === '+' ? 'text-primary' : 'text-danger'}>{transaction.type_signal_char} {<NumberFormat value={parseFloat(transaction.amount).toFixed(2)} displayType={'text'} thousandSeparator={true} prefix={'R$'} />}</td>
                  <td>{transaction.document}</td>
                  <td>{transaction.card_number}</td>
                  <td>{transaction.owner_name}</td>
                  <td>{transaction.company_name}</td>
                </tr>
              </tbody>
            ))}
            {company && (
              <tfoot>
                <tr>
                  <td colSpan={2} className="text-right font-weight-bold">Saldo da conta</td>
                  <td className="font-weight-bold">{company?.balance && <NumberFormat value={parseFloat(company?.balance).toFixed(2)} displayType={'text'} thousandSeparator={true} prefix={'R$'} />}</td>
                  <td colSpan={4}></td>
                </tr>
              </tfoot>
            )}
          </table>
        </div>
      </div>

    </div>
  );
}

export default TransactionList;
