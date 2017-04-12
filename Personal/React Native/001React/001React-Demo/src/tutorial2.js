var CommentList = React.createClass(
    {
        render: function () {
            return (
                React.createElement('div', {className: 'commentBox'}, "Hello World! I am a CommentList"
                )
            );
        }
    }
);

var CommentForm = React.createClass(
    {
        render: function () {
            return(
                <div>
                    Hello, world! I am a {this.props.name}
                </div>
            );
        }
    }
);

var CommentBox = React.createClass(
    {
        render: function () {
            return(
                <div className="commentBox">
                    <h1>Comments</h1>
                    <CommentList />
                    <CommentForm name="CommentForm"/>
                </div>
            );
        }
    }
);

ReactDOM.render(
    React.createElement(
        CommentBox, null
    ),
    document.getElementById('example')
);