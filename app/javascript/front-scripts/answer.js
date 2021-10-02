document.addEventListener('turbolinks:load', function(){
    let answers = document.querySelector('.answers')

    if(answers){
        answers.addEventListener('click', (e)=>{
            let { target } = e
            // console.log(target.classList)
            if(!target.classList.contains('edit-answer-link')) return;
    
            e.preventDefault()
    
            let answerId = target.dataset.answerId
            
            let formEdit = document.querySelector(`#edit-answer-${answerId}`)
            formEdit.classList.remove('hidden')
            target.classList.add('hidden')
        })
    }
})