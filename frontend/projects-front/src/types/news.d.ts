import { Image } from './global';

export interface News {
    id: number;
    news_cat_id: number;
    title: string;
    image: Image;
    image_title: string;
    text: string;
    created_at?: Date;
    updated_at?: Date;
}
        