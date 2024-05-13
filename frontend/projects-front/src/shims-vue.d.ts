/* eslint-disable */
import { AxiosInstance } from 'axios';

declare module '@vue/runtime-core' {
  export interface ComponentCustomProperties {
    $api: AxiosInstance;
    $baseURL: string;
    $isLoggedIn: () => boolean;
    $isAdminLoggedIn: () => boolean;
    $getAuthToken: () => string | null;
    $getAdminToken: () => string | null;
  }
}

declare module '*.vue' {
  import type { DefineComponent } from 'vue'
  const component: DefineComponent<{}, {}, any>
  export default component
}
