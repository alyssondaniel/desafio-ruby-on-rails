import axios from "axios";

const api = axios.create({
    baseURL: "http://localhost:3333",
    headers: { 'Authorization': 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlpJVTM4MU9kaXFPN1RudlQzSE9JMCJ9.eyJpc3MiOiJodHRwczovL2Rldi1kZXNhZmlvLnVzLmF1dGgwLmNvbS8iLCJzdWIiOiJFNmMzVzlDdWQwdEU1NGhvdTF0ZXJyUHRVREI1d2RxZkBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9yYWlscy1zZWN1cmUtYXBpIiwiaWF0IjoxNjA1NjM4NzgwLCJleHAiOjE2MDU3MjUxODAsImF6cCI6IkU2YzNXOUN1ZDB0RTU0aG91MXRlcnJQdFVEQjV3ZHFmIiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.opAglJKqsIKHBtkhWpNRC383o8b9ZLHma9fsb_mCuORmd-iK0gWo2AP93uTastfIK1xxtowlqrDNN51BzBUvEC-_ZSlH7XQ1PXZpLJ84CtOOgMrdS4MzS49yWf6l_ywTz1d8AEzNkv-n7X_P2AZz2k2Tsyx33IUojfOKSBRkFBIwC1eKZxCJ8B6EQkEw8DbzWU-c3Bv7GRgq48rcctk27j1tenzM5usgcrBww4OesCdcViXOEvndXZ1pmvnB_4X1BNvpLEfW5aZ_ZTqpZVTyi3fZ7Ani5JNJAJHRmRLaM2Y3Feoe69_B8CcJYUR-QgmQ_L2-x4Z_tuYtCxgBY-Nqbg' }
});

export default api;