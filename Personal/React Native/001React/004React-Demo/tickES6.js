var SetIntervalMixin = component =>class extends React.Component {

    componentWillMount(){
        this.intervals = [];
    }
    setInterval() {
        this.intervals.push(setInterval.apply(null, arguments));
    }
    componentWillUnmount() {
        this.intervals.forEach(clearInterval);
    }

    render(){
        return(
            <component {...this.props} {...this.state}/>
        )
    }
};

class TickTock extends React.Component{
    constructor(props){
        super(props);
        this.state={
            seconds:0,
        };
        this.intervals = [];
    }

    componentDidMount() {
        this.setInterval(() =>this.tick(), 1000);
    }
    tick() {
        this.setState({seconds: this.state.seconds + 1});
    }
    render() {
        return (
            <p>
                React has been running for {this.state.seconds} seconds.
            </p>
        );
    }
};
