document.addEventListener('turbolinks:load', ()=>{
    let questionsEdit = document.querySelector('.edit-question-link')

    if(questionsEdit){
        questionsEdit.addEventListener('click', (event)=>{
            event.preventDefault();
            
            let { target } = event

            let questionForm = document.querySelector(".edit-question-form")
            target.classList.add('hidden')
            questionForm.classList.remove('hidden')

            console.log("hello")
        })
    }
})