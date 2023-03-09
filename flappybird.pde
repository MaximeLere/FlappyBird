PImage fond, sol, tubeHaut, tubeBas, oiseau, gameOver, pièce, startMsg; //Déclaration de toutes les variables images
PImage[] perso; //Déclaration d'un tableau d'image utilisé pour animer l'oiseau
int positionSol, pièceX, pièceY, tubeX, tubeY, hauteur, i= 0; //Déclaration des variables devant contenir des nombres entiers
float  vitesse = 0.0; //Déclaration de la variable vitesse qui contient un nombre à virgule pour plus de précisions
boolean finDuJeu = false; //Déclaration d'une variable pour savoir si le joueur a perdu ou non
boolean firstTime = true;//Déclaration d'une variable pour savoir si c'est la première partie du joueur ou non
boolean touchePièce = false;

void setup() // fonction appelé une unique fois au début du programme. Elle est utilisée pour initialiser les variables déclarées plus haut avec différentes valeurs
{
  size(288,512); //détermine la taille de la fenêtre de jeu
  fond = loadImage("background-day.png"); //On affecte à chaque variable PImage une des images présentes dans le dossier "data" 
  sol = loadImage("base.png");
  tubeHaut = loadImage("tubeHaut.png");
  tubeBas = loadImage("tubeBas.png");
  oiseau = loadImage("yellowbird-upflap.png");
  gameOver = loadImage("gameover.png");
  startMsg = loadImage("message.png");
  perso = new PImage[3]; //On indique que le tableau pour animer l'oiseau disposera de 3 images
  perso[0] = loadImage("yellowbird-downflap.png"); //On attribue les différentes images pour animer l'oiseau dans le tableau, case par case
  perso[1] = loadImage("yellowbird-midflap.png");
  perso[2] = loadImage("yellowbird-upflap.png");
  tubeX = 300; // La position en X initiale des tuyaux
  tubeY = int(random(200, 300)); // La hauteur initiale des tuyaux
  vitesse = -5; // La vitesse initiale de l'oiseau
  hauteur = 100; // La hauteur initiale de l'oiseau
  finDuJeu = false; //Le joueur n'a pas encore perdu
  pièce = loadImage("coin.png");
  pièceX = 400;
  pièceY = int(random(200, 300));
}

void draw() // fonction principale qui va se relancer indéfiniment tant que le joueur ne quitte pas le jeu
{
if (finDuJeu == false && firstTime == false){
  changement();
  oiseau();
  jump();
  display();
  apparition();
  finDuJeu = chocOiseau();
  } else if (firstTime == true){
    display();
    startGame();
  } else {
  GameOver();
  }
if (touchePièce == true){
  disparition();
}
}

void GameOver()
{
  display();
  image(gameOver, 45, 192);
  if (keyPressed == true && key == 'r') {
    setup();
  }
}

void startGame()
 {
  image(startMsg, 50, 100);
  if (keyPressed == true && key == ' ') {
    firstTime = false;
  }
}


boolean chocOiseau()
{
  if (100 + 30 >= tubeX && 100 <= tubeX + 50) {
    if (hauteur <= tubeY - 130 || hauteur + 24 >= tubeY)
      return (true);
  }
  if (hauteur >= 372) {
    return (true);
  } else {
    return (false);
  }
}

void jump()
{
  if (keyPressed == true && key == ' ') {
    vitesse = -4;
  }
}

void changement()
{
  positionSol = positionSol - 2;
  tubeX = tubeX - 2;
  if(positionSol < -23)
  {
    positionSol = 0;
  }
  if(tubeX < -50)
  {
    tubeX = 300;
    tubeY = int(random(200, 300));
  }
}

void apparition()
{
  pièceX = pièceX -2;
  if(pièceX < -50)
  {
    pièceX = 350;
    pièceY = int(random(200, 300));
  }
}

void disparition() {
  pièceX = 350;
}

boolean touchePièce()
{
    if (hauteur <= pièceY - 130 || hauteur + 24 >= pièceY){
      return (true);
  } 
   return (false);
}

void oiseau()
{
  hauteur = int(hauteur + vitesse);
  vitesse = vitesse + 0.2;
  if (vitesse <= -0.5) {
    oiseau = perso[2];
  } else if (vitesse <= 0.5) {
    oiseau = perso[0];
  }
  else {
   oiseau = perso[1];
  }
}

void display() {
  clear();
  background(fond);
  image(tubeBas, tubeX, tubeY);
  image(tubeHaut, tubeX, tubeY - 450);
  image(sol, positionSol, 400);
  image(oiseau, 100, hauteur);
  image(pièce, pièceX, pièceY);
}
