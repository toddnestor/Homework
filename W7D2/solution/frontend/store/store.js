import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';
import { applyMiddleware } from 'redux';

const addLoggingToDispatch = store => next => action => {
  console.log(store.getState());
  console.log(action);
  let result = next(action);
  console.log(store.getState());
  return result;
};

const preloadedState = {
  notes: [],
  tracks: {},
  isRecording:false,
  isPlaying:false
}


const configureStore = (state = preloadedState) => (
  createStore(
    rootReducer,
    state,
    applyMiddleware( addLoggingToDispatch )
  )
);

export default configureStore;
