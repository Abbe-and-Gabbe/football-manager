import { writable } from 'svelte/store';

export const user = writable({
    id: 0,
    firstName: "",
    lastName: "",
    JWT: "",
    isLoggedIn: false,
})