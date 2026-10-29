// My Daily Journey

String[] data;
int stage = 0;
int design = 0;

void setup() {
  size(600, 600);
  data = loadStrings("dear_data_daily_journey (1).txt");
}

void draw() {
  background(20, 25, 40);
  translate(width/2, height/2);

  for (int i = 0; i < data.length; i++) {

    // Read the three journey times
    String[] values = split(data[i], ',');
    int walk = int(values[0]);
    int train = int(values[1]);
    int walkUni = int(values[2]);

    // Choose the time and colour
    int minutes = walk;
    if (stage == 1) minutes = train;
    if (stage == 2) minutes = walkUni;

    if (stage == 0) stroke(255, 80, 190);
    if (stage == 1) stroke(50, 210, 255);
    if (stage == 2) stroke(100, 255, 150);

    // Make train lines longer
    float scale = 8;
    if (stage == 1) scale = 5;

    // Draw the spiral
    float angle = TWO_PI * i / data.length;
    angle += map(mouseX, 0, width, -PI, PI);

    float radius = 40 + i * 5;
    if (design == 1) radius = 100;

    float x1 = cos(angle) * radius;
    float y1 = sin(angle) * radius;
    float x2 = cos(angle + 0.3) * (radius + minutes * scale);
    float y2 = sin(angle + 0.3) * (radius + minutes * scale);

    line(x1, y1, x2, y2);
    noStroke();
    fill(255);
    circle(x2, y2, 4);
  }

  // Show the title and controls
  resetMatrix();
  fill(255);
  textSize(20);
  text("MY DAILY JOURNEY", 20, 30);
  textSize(13);
  text("Move mouse to rotate | Click to change design", 20, 55);
  text("Press SPACE to change journey stage", 20, 75);

  if (stage == 0) text("WALK TO STATION", 20, 105);
  if (stage == 1) text("TRAIN JOURNEY", 20, 105);
  if (stage == 2) text("WALK TO UNIVERSITY", 20, 105);
}

void mousePressed() {
  design = 1 - design;
}

void keyPressed() {
  if (key == ' ') stage = (stage + 1) % 3;
}
