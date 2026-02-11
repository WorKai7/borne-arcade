package projet.Puissance_X;

interface Joueur {
	void nouvellePartie(int noJoueur, ConfigurationPartie config);
	int choisirColonne(Plateau grille);
}