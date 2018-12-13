class Bezier
  attr_reader :bezier_node
  def initialize
    @bezier_node = bezier_node
  end

  def off_button
    "<button onclick='var elem = document.getElementById(\"myCanvas\");elem.parentElement.removeChild(elem)'>No Mas Bezier</button>\n"
  end

  def bezier_node
      <<-CODE
      <script>
        document.addEventListener('DOMContentLoaded', function(){
          function clock() {
            function shuffle(a) {
              for (let i = a.length - 1; i > 0; i--) {
                  const j = Math.floor(Math.random() * (i + 1));
                  [a[i], a[j]] = [a[j], a[i]];
              }
              return a;
            }

            var cvs = document.getElementById('myCanvas')
            var farts = document.getElementById('farts')
            cvs.height = window.innerHeight
            cvs.width = window.innerWidth - farts.offsetWidth
            var ctx = cvs.getContext('2d');
            ctx.scale(0.3, 0.3);

            // if you remove this it makes the lines get all pixelated lol wonder why
            ctx.beginPath();

            var move1 = shuffle([10, 50, 100, 250])
            ctx.moveTo(move1,50);

            var curve_values = [10, 100, 1000, 20, 200, 2000, 30, 300, 3000, 40, 400, 4000, 50, 500, 5000, 60, 600, 6000, 70, 700, 7000, 80, 800, 8000, 90, 900, 9000]
            var to_sample = shuffle(curve_values)
            var a = to_sample[0]
            var b = to_sample[1]
            var c = to_sample[2]
            var d = to_sample[3]
            var e = to_sample[4]
            var f = to_sample[5]
            ctx.bezierCurveTo(a,b,c,d,e,f);

            ctx.stroke();

            setTimeout(() => {
              window.requestAnimationFrame(clock);
            }, 150)
          }
          window.requestAnimationFrame(clock);
        });
      </script>
      CODE
  end
end
