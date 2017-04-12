class LikeButton extends React.Component {
    constructor(props){
        super(props);
        this.state ={
            liked: false,
        }
    }

    buttonClick(){
        this.setState({
            liked: !this.state.liked,
        })
    }

    render(){
        const text = this.state.liked ? 'liked' : 'haven\'t liked';
        return(
            <div onClick={() => this.buttonClick()}>
                You {text} this. Click to toggle.
            </div>
        );
    }
}

ReactDOM.render(
    <LikeButton />,
    document.getElementById('example')
);