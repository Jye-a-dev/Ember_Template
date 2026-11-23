export interface ApiResponse<T> {
  data: T;
  message?: string;
  status: number;
}

export interface ApiErrorResponse {
  error: string;
  message: string;
  statusCode: number;
}
