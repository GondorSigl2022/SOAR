import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export interface Cocktail {
    readonly id: string,
    readonly content: string
    readonly name: string
}

export interface NotesState {
    readonly notes: Cocktail[],
    readonly errorMessage: null | string
}

const initialState: NotesState = {
    notes: [],
    errorMessage: null
};

export const createNote = createAsyncThunk<Cocktail, { readonly content: string, readonly name: string}, { rejectValue: { readonly errorMessage: string, readonly cocktail: Cocktail } }>(
    'notes/create',

    async (arg, thunkAPI) => {
        const cocktail: Cocktail = { id: Math.random().toString(), name: arg.name, content: arg.content };
        return await fetch(
            '/api/cocktails/',
            {
                method: 'POST',
                body: JSON.stringify(cocktail)
            })

            .then(response => {
                if (response.status === 201) {
                    return cocktail;
                } else {
                    throw new Error(`Unexpected response from server (code ${response.status}).`);
                }
            })

            .catch(function (error) {
                console.error(error);
                return thunkAPI.rejectWithValue({ errorMessage: error.message, cocktail});
            });
    }
);


export const fetchNotes = createAsyncThunk<Cocktail[], void, { rejectValue: string }>(
    'cocktails/fetch',
    async (arg, thunkAPI) => {
        return await fetch(
            '/api/cocktails/',
            {
                method: 'GET'
            })

            .then(response => {
                if (response.status === 200) {
                    return response.json();
                } else {
                    throw new Error(`Unexpected response from server (code ${response.status}).`);
                }
            })

            .catch(function (error) {
                console.error(error);
                return thunkAPI.rejectWithValue(error.message);
            });
    }
);

export const notesSlice = createSlice({
    name: 'cocktails',
    initialState,
    reducers: {
        reset: () => initialState
    },
    extraReducers: (builder) => {
        builder
            .addCase(createNote.fulfilled, (state, action) => {
                state.notes.unshift(action.payload);
                state.errorMessage = null;
            });

        builder
            .addCase(createNote.rejected, (state, action) => {
                if (action.payload !== undefined) {
                    state.notes.unshift(action.payload.cocktail);
                    state.errorMessage = action.payload.errorMessage;
                }
            });


        builder
            .addCase(fetchNotes.fulfilled, (state, action) => {
                state.notes = action.payload;
            });

        builder
            .addCase(fetchNotes.rejected, (state, action) => {
                state.errorMessage = action.payload ?? null;
            });
    },
});

export default notesSlice.reducer;
