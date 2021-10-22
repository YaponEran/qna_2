import consumer from "./consumer";

consumer.subscriptions.create({channel: "CommentsChannel", question_id: gon.question_id}, {
    received(data){
        this.addComment(data)
        console.log(data.comment.commentable_type)
    },

    addComment(data){
        if (gon.user_id == data.comment.user_id) return;

        const template = require('../views/comment.hbs')
        const htmlComment = template(data)

        const resourceType = data.comment.commentable_type

        if(resourceType == "Question"){
            const questionComment = document.querySelector(".comment-box")
            questionComment.insertAdjacentHTML('beforeend', htmlComment)
        }else if(resourceType == "Answer"){
            const answerComment = document.querySelector(`div[data-answer-node-id="${data.comment.commentable_id}"]`)
            const answerCommentBox = answerComment.querySelector(".answer-comment-box")

            answerCommentBox.insertAdjacentHTML('beforeend', htmlComment)
        }
    }
})