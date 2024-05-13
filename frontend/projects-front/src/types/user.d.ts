import { Image } from './global';

export interface User {
    id: number;
    name: string;
    username: string;
    image_url: string;
    profile?: string;
    is_following?: boolean;
}

export interface CurrentUser {
    id: number;
    name: string;
    username: string;
    email: string;
    zip: string;
    prefecture: string;
    city: string;
    street: string;
    address?: string;
    tel: string;
    image: Image;
    photo?: string;
    audio?: string;
    video?: string;
    profile?: string;
    introduction?: string;
    created_at?: Date;
    updated_at?: Date;
}

export interface NewUser {
    id: number;
    name: string;
    username: string;
    email: string;
    password: string;
    zip: string;
    prefecture: string;
    city: string;
    street: string;
    tel: string;
    profile: string;
}