import consumer from "./consumer";

let url = window.location.href
let question_id = parseInt(url.substring(url.search("questions/") + 10))

consumer.subscriptions.create({channel: "AnswersChannel", question_id: gon.question_id}, {
    received(data){
        this.addAnswer(data)
    },

    addAnswer(data){
        if(gon.user_id == data.answer.user_id) return;

        const template = require('../views/answer.hbs')
        const answersNode = document.querySelector('.answers')

        answersNode.insertAdjacentHTML('beforeEnd', template(data));
    }
})