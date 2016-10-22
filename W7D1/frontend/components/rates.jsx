import React from 'react';
import Currency from './currency';

const Rates = ({rates}) => (
  <div className="rates-list">
    {
      Object.keys(rates).map( (currency) => (
          <Currency name={currency}
                    rate={rates[currency]}
                    key={currency} />
        )
      )
    };
  </div>
);

export default Rates;