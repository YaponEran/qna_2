document.addEventListener('turbolinks:load', ()=>{
    let questionsEdit = document.querySelector('.edit-question-link')

    if(questionsEdit){
        questionsEdit.addEventListener('click', (event)=>{
            let { target } = event

            event.preventDefault()

            let questionForm = document.querySelector(".edit-question-form")
            target.classList.add('hidden')
            questionForm.classList.remove('hidden')
        })
    }
})
