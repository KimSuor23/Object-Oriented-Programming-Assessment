/**
 * 
 */
function readMore(e) {
const mybutton = e.target
if (!mybutton) {
console.log('The button element does not exist')
return
}
const container = mybutton.closest('.container')
if (!container) return
const mycontent = container.querySelector('.extra')
if (!mycontent) return
   if (mycontent.style.display === 'none'
       || mycontent.style.display === '') {
       mycontent.style.display = 'block';
       mybutton.textContent = '<<Read Less';
   } else {
       mycontent.style.display = 'none';
       mybutton.textContent = 'Read More>>';
   }
}
