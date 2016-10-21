import React from 'react';

class Calculator extends React.Component{
  constructor(props){
    super(props);
    this.state = {result: 0, num1: '', num2: ''}
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);
    this.add = this.add.bind(this);
    this.subtract = this.subtract.bind(this);
    this.multiply = this.multiply.bind(this);
    this.divide = this.divide.bind(this);
    this.clearEverything = this.clearEverything.bind(this);
  }

  setNum1(e) {
    let num1 = parseInt( e.currentTarget.value );
    this.setState({num1});
  }

  setNum2(e) {
    let num2 = parseInt( e.currentTarget.value );
    this.setState({num2});
  }

  add(e) {
    e.preventDefault();
    let {num1, num2} = this.state;
    let result = num1 + num2;
    this.setState({result});
  }

  subtract(e) {
    e.preventDefault();
    let {num1, num2} = this.state;
    let result = num1 - num2;
    this.setState({result});
  }

  multiply(e) {
    e.preventDefault();
    let {num1, num2} = this.state;
    let result = num1 * num2;
    this.setState({result});
  }

  divide(e) {
    e.preventDefault();
    let {num1, num2} = this.state;
    let result = num1 / num2;
    this.setState({result});
  }

  clearEverything(e) {
    e.preventDefault();
    this.setState({num1: '', num2: '', result: 0});
  }

  render(){
    let {result, num1, num2} = this.state;
    return (
      <div>
        <h1>{result}</h1>
        <div className="container">
          <div className="col-1-2">
            <input type="number" onChange={this.setNum1} value={num1} />
          </div>
          <div className="col-1-2">
            <input type="number" onChange={this.setNum2} value={num2} />
          </div>
        </div>
        <div className="container">
          <div className="col-1-2">
            <button onClick={this.add}>+</button>
            <button onClick={this.subtract}>-</button>
            <button onClick={this.multiply}>*</button>
            <button onClick={this.divide}>/</button>
            <button onClick={this.clearEverything}>Clear</button>
          </div>
        </div>
      </div>
    );
  }
}

export default Calculator;
