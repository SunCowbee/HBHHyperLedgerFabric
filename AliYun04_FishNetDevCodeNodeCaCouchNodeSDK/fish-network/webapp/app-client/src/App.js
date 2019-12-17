import React from 'react';
import axios from 'axios';

class App extends React.Component {
  state = {items: []};

  async componentDidMount() {
    let result = await axios.get('http://47.88.50.237:3001/queryAllFish');
    console.log(result.data);
    this.setState({
      items: result.data
    });
  }

  render() {
    let content = [];
    this.state.items.forEach((value) => {
      content.push(<h3> {value.Key}, {value.Record.holder}</h3>)
    });
    return (
        <div>
          {content}
          {<h3>hello world</h3>}
        </div>
    )
  }
}
export default App;
