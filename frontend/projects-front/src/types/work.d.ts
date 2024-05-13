import { Image } from './global';

export interface Work {
    id: number;
    work_cat_id: number;
    title: string;
    image: Image;
    price: number;
    text: string;
    onlyone: boolean;
    status: string;
    created_at?: Date;
    updated_at?: Date;
}

export interface CartWork extends Work {
    cart_work_id: number;
    quantity: number;
}
