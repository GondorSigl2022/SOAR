import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';

export interface Cocktail {
    readonly id: string,
    readonly ingredients: string
    readonly name: string
}

export interface CocktailsState {
    readonly cocktails: Cocktail[],
    readonly errorMessage: null | string
}

const initialState: CocktailsState = {
    cocktails: [],
    errorMessage: null
};

export const createCocktail = createAsyncThunk<Cocktail, { readonly ingredients: string, readonly name: string}, { rejectValue: { readonly errorMessage: string, readonly cocktail: Cocktail } }>(
    'cocktails/create',

    async (arg, thunkAPI) => {
        const cocktail: Cocktail = { id: Math.random().toString(), name: arg.name, ingredients: arg.ingredients };
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


export const fetchCocktails = createAsyncThunk<Cocktail[], void, { rejectValue: string }>(
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

export const cocktailsSlice = createSlice({
    name: 'cocktails',
    initialState,
    reducers: {
        reset: () => initialState
    },
    extraReducers: (builder) => {
        builder
            .addCase(createCocktail.fulfilled, (state, action) => {
                state.cocktails.unshift(action.payload);
                state.errorMessage = null;
            });

        builder
            .addCase(createCocktail.rejected, (state, action) => {
                if (action.payload !== undefined) {
                    state.cocktails.unshift(action.payload.cocktail);
                    state.errorMessage = action.payload.errorMessage;
                }
            });


        builder
            .addCase(fetchCocktails.fulfilled, (state, action) => {
                state.cocktails = action.payload;
            });

        builder
            .addCase(fetchCocktails.rejected, (state, action) => {
                state.errorMessage = action.payload ?? null;
            });
    },
});

export default cocktailsSlice.reducer;
