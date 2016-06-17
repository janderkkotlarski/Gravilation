

final float wind = 700;

final float quart = 0.25*wind;

final float grav = 100;

final float spd_mult = 0.003;
final float spd_max = spd_mult*wind;

final float diam = 10;
final float radius = 0.5*diam;

final int amount = 4;

float pos_x[] = new float[amount];
float pos_y[] = new float[amount];

float spd_x[] = new float[amount];
float spd_y[] = new float[amount];

float acc_x[] = new float[amount];
float acc_y[] = new float[amount];

float charge[] = new float[amount];

void setup()
{
  size(700, 700);
  background(0);
  noStroke();
  
  for (int count = 0; count < amount; ++count)
  {
    pos_x[count] = random(quart, wind - quart);
    pos_y[count] = random(quart, wind - quart);
    
    spd_x[count] = random(-spd_max, spd_max);
    spd_y[count] = random(-spd_max, spd_max);
    
    charge[count] = random(-1, 1);
  }  
}

color charge_color(float charge)
{
  final color charger = color(127 + charge*64, 127, 127 - charge*64);
  
  return charger;
}

float windizer(float pos, final float wind)
{
  while (pos < 0)
  {
    pos += wind;
  }
  
  while (pos > wind)
  {
    pos -= wind;
  }
  
  return pos;
}

float windeeber(float pos, final float wind, float spd)
{
  if ((pos < 0) || (pos > wind))
  {
    spd = -spd;
  }
  
  return spd;
}

float windobber(float pos, final float wind)
{
  while (pos < 0)
  {
    pos = -pos;
  }
  
  while (pos > wind)
  {
    pos = wind + wind - pos;
  }
  
  return pos;
}

void draw()
{
  background(0);
  // fill(63, 127, 191);
  
  for (int count = 0; count < amount; ++count)
  {
    fill(charge_color(charge[count]));
    ellipse(pos_x[count], pos_y[count], diam, diam);
  }  
  
  for (int count = 0; count < amount - 1; ++count)
  {
    for (int count_2 = count + 1; count_2 < amount; ++count_2)
    {
      final float dist_x = pos_x[count] - pos_x[count_2];
      final float dist_y = pos_y[count] - pos_y[count_2];
      final float dist_2 = dist_x*dist_x + dist_y*dist_y;
      final float dist = sqrt(dist_2) + radius;
      
      final float acc = charge[count]*charge[count_2]*grav/dist;
      
      final float acc__x = acc*dist_x/dist;
      final float acc__y = acc*dist_y/dist;
      
      acc_x[count] = acc__x;
      acc_y[count] = acc__y;
      acc_x[count_2] = -acc__x;
      acc_y[count_2] = -acc__y;
    }
  }
  
  for (int count = 0; count < amount; ++count)
  {
    spd_x[count] += acc_x[count];
    spd_y[count] += acc_y[count];
    
    pos_x[count] += spd_x[count];
    pos_y[count] += spd_y[count];
    
    spd_x[count] = windeeber(pos_x[count], wind, spd_x[count]);
    spd_y[count] = windeeber(pos_y[count], wind, spd_y[count]);
    
    pos_x[count] = windobber(pos_x[count], wind);
    pos_y[count] = windobber(pos_y[count], wind);
  }  
  
}
