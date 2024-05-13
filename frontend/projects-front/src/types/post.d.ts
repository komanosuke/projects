export interface Post {
    id: number;
    user_id: number;
    user_name: string;
    user_username: string;
    user_image_url: string;
    content: string;
    image_url: string;
    is_following: boolean;
    initial_liked: boolean;
    initial_likes_count: number;
    initial_comments_count: number,
    created_at?: Date;
    updated_at?: Date;
}
