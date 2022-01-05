import React, { useState, useEffect } from 'react';

import { useAppSelector, useAppDispatch } from '../../app/hooks';
import { createCocktail, fetchCocktails, cocktailsSlice } from './cocktailSlice';

export const Cocktails = () => {
    const reduxState = useAppSelector(state => state);
    const reduxDispatch = useAppDispatch();
    const [newCocktailIngredients, setNewCocktailIngredients] = useState('');
    const [newNameCocktail, setNameCocktail] = useState('');

    useEffect(() => {
        reduxDispatch(fetchCocktails());
    }, [reduxDispatch]);

    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', flexDirection: 'column' }}>
            {
                reduxState.cocktails.errorMessage !== null
                &&
                <strong>Error: {reduxState.cocktails.errorMessage}</strong>
            }
            <h1>GondorCap Dashboard</h1>
            <h2>Add Cocktail</h2>
            <form onSubmit={(e) => {
                reduxDispatch(createCocktail({ ingredients: newCocktailIngredients, name: newNameCocktail }));
                e.preventDefault();
            }}>
                <input
                    type='text'
                    className='form-control'
                    id='create-server-title'
                    placeholder='Title'
                    value={newNameCocktail}
                    onChange={(e) => setNameCocktail(e.target.value)}
                />

                <input
                    type='text'
                    className='form-control'
                    id='create-server-title'
                    placeholder='Recipe'
                    value={newCocktailIngredients}
                    onChange={(e) => setNewCocktailIngredients(e.target.value)}
                />

                <button type='submit' disabled={newCocktailIngredients.length < 1}>
                    Add
                </button>
            </form>

            <h2>Your Cocktails</h2>
            <p>
                <button
                    onClick={() => reduxDispatch(fetchCocktails())}
                >
                    Re-fetch cocktails from backend
                </button>
            </p>
            {reduxState.cocktails.cocktails.map(cocktail => (
                <div>
                    {/* <small>{cocktail.id}</small> */}
                    <br />
                    {"Name : " + cocktail.name}
                    <br />
                    {"Ingrédients : " + cocktail.ingredients}
                    <hr />
                </div>
            ))}
        </div>
    );
};
