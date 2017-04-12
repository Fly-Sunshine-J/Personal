var data = [
    {id: 1, author: "Pete Hunt", text: "This is one comment"},
    {id: 2, author: "Jordan Walke", text: "This is *another* comment"}
];

var Comment = React.createClass({
    render(){
        return(
            <div>
                <h3>{this.props.author}</h3>
                <p>{this.props.id}</p>
                <p>{this.props.children}</p>
            </div>
        );
    }
});

var CommentList = React.createClass({
    render(){
        var commentNodes = this.props.data.map(function (comment) {
            return(
                <Comment author={comment.author} id={comment.id}>
                    {comment.text}
                </Comment>
            );
        })
        return(
            <div>
                {commentNodes}
            </div>
        );
    }
});


var CommentForm = React.createClass({
    getInitialState(){
      return {author: '', text: ''};
    },
    handleAuthorChange(e){
        this.setState({author: e.target.value})
    },
    handleTextChange(e){
      this.setState({text: e.target.value})
    },
    handleSubmit(e){
        e.preventDefault();
        var author = this.state.author.trim();
        var text = this.state.text.trim();
        if (!author || !text){
            return;
        }
        //提交
        this.props.onCommentSubmit({author: author, text: text});
        this.setState({author: '', text: ''});
    },
    render(){
        return(
            <form className="commentForm" onSubmit={this.handleSubmit.bind(this)}>
                <input type="text" placeholder="Your Name" value={this.state.author} onChange={this.handleAuthorChange.bind(this)}/>
                <input type="text" placeholder="Say something.." value={this.state.text} onChange={this.handleTextChange.bind(this)}/>
                <input type="submit" value="post"/>
            </form>
        );
    }
});

var CommentBox = React.createClass({
    getInitialState() {
        return {data: []};
    },

    loadDataFromServer() {
        $.ajax({
            url: this.props.url,
            dataType: 'json',
            cache: false,
            success: function (data) {
                this.setState({data: data});
            }.bind(this),
            error: function (xhr, status, err) {
                console.log(this.props.url, status, err.toString());
            }.bind(this)
        });
    },

    componentDidMount(){
        this.loadDataFromServer();
        setInterval(this.loadDataFromServer, this.props.pollInterval);
    },

    handleCommentSubmit(comment){

        var comments = this.state.data;
        comment.id = Date.now();
        var newComment = comments.concat([comment]);
        this.setState({data: newComment});

        $.ajax({
            url: this.props.url,
            dataType: 'json',
            type: 'POST',
            data: comment,
            success: function(data) {
                this.setState({data: data});
            }.bind(this),
            error: function(xhr, status, err) {
                this.setState({data: comments});
                console.error(this.props.url, status, err.toString());
            }.bind(this)
        });
    },

    render(){
        return(
            <div>
                <h1>Comment</h1>
                <CommentList data={this.state.data}/>
                <CommentForm onCommentSubmit={this.handleCommentSubmit.bind(this)}/>
            </div>
        );
    }
});

ReactDOM.render(
    <CommentBox url="./comments.json" pollInterval={2000}/>,
    document.getElementById('example')
);