var CommentBox = React.createClass(
    {
        render: function () {
            return(
                <div className="commnetBox">
                    Hello, world! I am a CommentBox.
                </div>
            );
        }
    }
);


ReactDOM.render(
    <CommentBox />,
    document.getElementById('example')
);