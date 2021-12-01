$(function (){
    const shell = document.querySelector(".shell")
    const video = document.querySelector(".video")
    shell.addEventListener('mouseenter', function(e) {
        this.x = e.clientX
        video.style.transition = 'none'
    })
    shell.addEventListener('mousemove', function(e) {
        this._x = e.clientX
        const disx = this._x - this.x
        const move = 36 - disx / -20
        video.style.transform = `translate(${move}px,-8px)`
    })
    shell.addEventListener('mouseleave', function(e) {
        video.style.transition = .3 + 's'
        video.style.transform = 'translate(36px,-8px)'
    })
})