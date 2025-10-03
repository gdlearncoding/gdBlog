new TypeIt("#tqyxhj", {
        loop: true,
        cursorSpeed: 1000,
        speed: 100
    })
    .type("YM OAO GD")
    .pause(2000)
    .delete(null, {
        delay: 500
    })
    .type("一起进入下一个百天...")
    .pause(3000)
    .go();

new TypeIt('#talkToXHJ', {
    lifeLike: true,
    cursorSpeed: 1000,
    waitUntilVisible: true,
    speed: 100
}).go();