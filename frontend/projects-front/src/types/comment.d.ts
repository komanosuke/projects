import { Image } from './global';

export interface Comment {
    id: number;
    content: string;
    user_id: number;
    user_name: string;
    user_username: string;
    user_image_url: string;
    created_at?: Date;
    updated_at?: Date;
}
