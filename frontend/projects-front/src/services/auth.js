export function isLoggedIn() {
    return !!localStorage.getItem('authToken');
}

export function isAdminLoggedIn() {
    return !!localStorage.getItem('adminToken');
}

export function getAuthToken() {
    return localStorage.getItem('authToken');
}

export function getAdminToken() {
    return localStorage.getItem('adminToken');
}