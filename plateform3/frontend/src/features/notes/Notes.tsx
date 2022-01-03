import React, { useState, useEffect } from 'react';

import { useAppSelector, useAppDispatch } from '../../app/hooks';
import { createNote, fetchNotes, notesSlice } from './notesSlice';

export const Cocktails = () => {
    const reduxState = useAppSelector(state => state);
    const reduxDispatch = useAppDispatch();
    const [newNoteContent, setNewNoteContent] = useState('');
    const [newNameCocktail, setNameCocktail] = useState('');

    useEffect(() => {
        reduxDispatch(fetchNotes());
    }, [reduxDispatch]);

    return (
        <div>
            {
                reduxState.notes.errorMessage !== null
                &&
                <strong>Error: {reduxState.notes.errorMessage}</strong>
            }
            <h1>Add note</h1>
            <form onSubmit={ (e) => {
                reduxDispatch(createNote({ content: newNoteContent, name :  newNameCocktail}));
                e.preventDefault();
            }}>
                <input
                    type='text'
                    className='form-control'
                    id='create-server-title'
                    placeholder=''
                    value={newNoteContent}
                    onChange={ (e) => setNewNoteContent(e.target.value) }
                />
                <input
                    type='text'
                    className='form-control'
                    id='create-server-title'
                    placeholder=''
                    value={newNameCocktail}
                    onChange={ (e) => setNameCocktail(e.target.value) }
                />
                <button type='submit' disabled={newNoteContent.length < 1}>
                    Add
                </button>                
            </form>

            <h1>Your notes</h1>
            <p>
                <button
                    onClick={() => reduxDispatch(fetchNotes())}
                >
                    Re-fetch notes from backend
                </button>
            </p>
            <p>
                <button onClick={ () => reduxDispatch(notesSlice.actions.reset()) }>
                    Reset
                </button>
            </p>
            {reduxState.notes.notes.map(cocktail => (
                <div>
                    <small>{cocktail.id}</small>
                    <br/>
                    {cocktail.name}
                    <hr/>
                    <br/>
                    {cocktail.content}
                    <hr/>
                </div>
            ))}
        </div>
    );
};
