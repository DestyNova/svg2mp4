var system = require('system'),
    args = system.args,
    svgPath = args[1],
    time = args.length > 2 ? parseInt(args[2]) : 5,
    fps = args.length > 3 ? parseInt(args[3]) : 30,
    frames = time * fps,
    width = args.length > 4 ? parseInt(args[4]) : 1280,
    height = args.length > 5 ? parseInt(args[5]) : 720,
    page = require("webpage").create();

page.viewportSize = { width: width, height: height };

// Helpers
String.prototype.padStart = function(len, c) {
  var padding = c.repeat(Math.max(0, len - this.length));
  return padding + this;
}

console.error = function () {
  require("system").stderr.write(Array.prototype.join.call(arguments, ' ') + '\n');
};

// Do it
var frame = 0;
setInterval(function() {
  if(frame >= frames)
    phantom.exit();
  else {
    console.error("Writing frame " + frame++);
    page.render("anim_" + String(frame++).padStart(5, "0") + ".png", { format: "png" });
  }
}, fps);

page.open(svgPath, function start(status) {
  console.log("Opened SVG");
});
