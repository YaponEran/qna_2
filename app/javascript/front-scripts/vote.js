document.addEventListener('turbolinks:load', function(){
    const vote_handler = (event)=>{
        let {target} = event
        if(!target.parentNode.classList.contains('voting')) return;

        console.log(event.detail[0])

        const { id, name, raiting } = event.detail[0]
        
        const query = `[data-${name}-node-id="${id}"] .raiting`
        const elem = document.querySelector(query)
        elem.innerHTML = `${raiting}`

        console.log(query)

    }

    const error_handler = (event)=>{
        const { message } = event.detail[0]

        const question_errors = document.querySelector('.question-errors')
        const errorsHtml = `<p>${message}</p>`

        question_errors.innerHTML = errorsHtml
    }

    const control = document.querySelector(".container")

    if(control){
        control.addEventListener("ajax:success", vote_handler.bind(this))
        control.addEventListener("ajax:error", error_handler.bind(this))
    }
})