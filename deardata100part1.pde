
/*
  DEAR DATA: MY DAILY JOURNEY
  Each row represents one journey.
  Each coloured section shows time in minutes.
*/

int[] walkToStation = {
  10, 8, 11, 6, 13, 9, 7, 12, 5, 10,
  14, 8, 9, 15, 6, 11, 7, 10, 12, 8,
  13, 9, 5, 14, 10
};

int[] train = {
  40, 37, 44, 35, 42, 39, 46, 41, 36, 48,
  43, 34, 40, 45, 38, 42, 33, 47, 39, 41,
  44, 36, 43, 37, 46
};

int[] walkToUniversity = {
  10, 12, 7, 9, 11, 8, 14, 10, 8, 13,
  9, 6, 11, 10, 12, 8, 9, 14, 7, 10,
  6, 12, 11, 9, 10
};

// Colours for each part of the journey
color backgroundColour = color(15, 25, 43);
color stationColour = color(220, 90, 220);
color trainColour = color(50, 210, 230);
color universityColour = color(255, 175, 100);
color textColour = color(240, 245, 255);

int chartX = 175;
int chartY = 155;
int rowHeight = 25;
float scale = 8;

void setup() {
  size(1000, 900);
  smooth(4);
  textFont(createFont("Arial", 14));
  noLoop();
}

void draw() {
  background(backgroundColour);

  // Main title
  fill(textColour);
  textSize(30);
  text("MY DAILY JOURNEY", 35, 45);

  textSize(14);
  fill(170, 195, 220);
  text("25 journeys | 3 stages | Time measured in minutes",
       35, 72);

  // Legend
  drawLegend(35, 100);

  // Chart grid and time labels
  drawGrid();

  // Draw every journey
  for (int i = 0; i < 25; i++) {
    drawJourney(i);
  }

  // Summary statistics
  drawSummary();

  // Footer
  fill(170, 195, 220);
  textSize(12);
  text("Each row shows the time taken for one complete journey.",
       35, 855);
}

void drawLegend(int x, int y) {
  noStroke();
  textSize(12);

  fill(stationColour);
  rect(x, y - 10, 12, 12, 3);
  fill(textColour);
  text("Walk to station", x + 18, y);

  fill(trainColour);
  rect(x + 155, y - 10, 12, 12, 3);
  fill(textColour);
  text("Train", x + 173, y);

  fill(universityColour);
  rect(x + 235, y - 10, 12, 12, 3);
  fill(textColour);
  text("Walk to university", x + 253, y);
}

void drawGrid() {
  textSize(11);
  textAlign(CENTER, CENTER);

  // Vertical grid lines every 10 minutes
  for (int minutes = 0; minutes <= 70; minutes += 10) {
    float x = chartX + minutes * scale;

    stroke(65, 85, 110, 110);
    strokeWeight(1);
    line(x, chartY - 15, x, chartY + 25 * rowHeight);

    fill(175, 195, 220);
    noStroke();
    text(minutes, x, chartY - 27);
  }

  textAlign(LEFT, CENTER);

  // Column heading
  fill(175, 195, 220);
  text("JOURNEY", 35, chartY - 27);
  text("TOTAL", 780, chartY - 27);
}

void drawJourney(int i) {
  float y = chartY + i * rowHeight;

  // Alternate background shading makes rows easier to read
  if (i % 2 == 0) {
    noStroke();
    fill(255, 255, 255, 8);
    rect(25, y - 10, 940, rowHeight);
  }

  // Journey number
  fill(textColour);
  textSize(12);
  textAlign(LEFT, CENTER);
  text(i + 1, 45, y);

  float x = chartX;

  // First section: walk to station
  drawSegment(x, y, walkToStation[i], stationColour);
  x += walkToStation[i] * scale;

  // Second section: train
  drawSegment(x, y, train[i], trainColour);
  x += train[i] * scale;

  // Third section: walk to university
  drawSegment(x, y, walkToUniversity[i], universityColour);
  x += walkToUniversity[i] * scale;

  // Calculate total duration
  int total = walkToStation[i]
            + train[i]
            + walkToUniversity[i];

  // Display total time at the end of the bar
  fill(textColour);
  textSize(12);
  text(total + " min", x + 7, y);
}

void drawSegment(float x, float y, int minutes, color segmentColour) {
  noStroke();
  fill(segmentColour);

  // Bar length is proportional to the time taken
  rect(x, y - 6, minutes * scale, 12, 4);
}

void drawSummary() {
  int totalStation = 0;
  int totalTrain = 0;
  int totalUniversity = 0;

  int shortest = 999;
  int longest = 0;

  for (int i = 0; i < 25; i++) {
    totalStation += walkToStation[i];
    totalTrain += train[i];
    totalUniversity += walkToUniversity[i];

    int total = walkToStation[i]
              + train[i]
              + walkToUniversity[i];

    if (total < shortest) shortest = total;
    if (total > longest) longest = total;
  }

  float averageStation = totalStation / 25.0;
  float averageTrain = totalTrain / 25.0;
  float averageUniversity = totalUniversity / 25.0;

  float averageTotal = (totalStation
                      + totalTrain
                      + totalUniversity) / 25.0;

  int boxY = chartY + 25 * rowHeight + 35;

  // Summary panel
  noStroke();
  fill(30, 45, 67);
  rect(30, boxY, 930, 115, 12);

  fill(textColour);
  textSize(17);
  text("JOURNEY STATISTICS", 50, boxY + 25);

  textSize(13);

  fill(stationColour);
  text("Average walk to station: "
       + nf(averageStation, 0, 1) + " min",
       50, boxY + 53);

  fill(trainColour);
  text("Average train: "
       + nf(averageTrain, 0, 1) + " min",
       340, boxY + 53);

  fill(universityColour);
  text("Average walk to university: "
       + nf(averageUniversity, 0, 1) + " min",
       590, boxY + 53);

  fill(textColour);
  text("Average total: "
       + nf(averageTotal, 0, 1) + " min",
       50, boxY + 83);

  text("Shortest: " + shortest + " min"
       + "     Longest: " + longest + " min",
       340, boxY + 83);
}
