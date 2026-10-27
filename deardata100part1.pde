
 // -- My Daily Journey

String[] data;
int stage = 0;

void setup() {
  size(400, 400);
  data = loadStrings("dear_data_daily_journey (1).txt");
}

void draw() {
  background(255);
  translate(width/2, height/2);

  for (int i = 0; i < 25; i++) {
    String[] values = split(data[i], ',');

    int time = int(values[stage]);

    float angle = TWO_PI * i / 25;
    float length = time * 3;

    if (stage == 0) stroke(230, 70, 180);
    if (stage == 1) stroke(40, 170, 230);
    if (stage == 2) stroke(50, 170, 90);

    line(0, 0, cos(angle) * length,
               sin(angle) * length);
  }

  resetMatrix();
  fill(0);
  text("MY DAILY JOURNEY", 10, 20);
  text("Click to change stage", 10, 40);

  if (stage == 0) text("Walking to station", 10, 60);
  if (stage == 1) text("Train", 10, 60);
  if (stage == 2) text("Walking to university", 10, 60);
}

void mousePressed() {
  stage = (stage + 1) % 3;
}
