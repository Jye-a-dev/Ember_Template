/* eslint-disable warp-drive/no-external-request-patterns */
import Service from '@ember/service';
import { env } from '@/config/env';
import type { ApiResponse } from '@/types/api';

export default class ApiClientService extends Service {
  readonly baseUrl: string = env.VITE_API_BASE_URL;

  async get<T>(endpoint: string): Promise<ApiResponse<T>> {
    const url = `${this.baseUrl}${endpoint.startsWith('/') ? endpoint : `/${endpoint}`}`;
    const response = await fetch(url, {
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
      },
    });

    if (!response.ok) {
      throw new Error(`API Request failed with status ${response.status}`);
    }

    return (await response.json()) as ApiResponse<T>;
  }

  async post<T, B>(endpoint: string, body: B): Promise<ApiResponse<T>> {
    const url = `${this.baseUrl}${endpoint.startsWith('/') ? endpoint : `/${endpoint}`}`;
    const response = await fetch(url, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Accept: 'application/json',
      },
      body: JSON.stringify(body),
    });

    if (!response.ok) {
      throw new Error(`API Request failed with status ${response.status}`);
    }

    return (await response.json()) as ApiResponse<T>;
  }
}

declare module '@ember/service' {
  interface Registry {
    'api-client': ApiClientService;
  }
}
