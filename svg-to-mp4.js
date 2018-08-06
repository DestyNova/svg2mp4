var system = require('system'),
    args = system.args,
    svgPath = args[1],
    time = args.length > 2 ? parseInt(args[2]) : 5,
    fps = args.length > 3 ? parseInt(args[3]) : 30,
    frames = time * fps,
    width = args.length > 4 ? parseInt(args[4]) : 1280,
    height = args.length > 5 ? parseInt(args[5]) : 720,
    slowdownFactor = args.length > 6 ? parseInt(args[6]) : 10,
    page = require("webpage").create();

page.viewportSize = { width: width, height: height };

var frame = 0,
    trueFps = fps / slowdownFactor,
    timingInterval = 1000 / trueFps;

setInterval(function() {
  if(frame >= frames)
    phantom.exit();
  else {
    console.log("Writing frame " + frame++);
    page.render("/dev/stderr", { format: "png" });
  }
}, timingInterval);

page.open(svgPath, function start(status) {
  console.log("Opened SVG");
});
