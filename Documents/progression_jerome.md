# Document de progression

---

**Auteur**: Jérôme Vandewalle

---

## Menu borne

Le menu de la borne ne fonctionnait pas dès le départ, il y a fallu installer la bibliothèque MG2D et la placer à la racine du projet de borne pour y avoir accès. Puis il fallait ensuite corriger dans les fichiers du menu de la borne l'importation de ```MG2D.geometrie.Couleur``` par ```MG2D.Couleur```. La version de MG2D anciennement utilisée devait contenir une architecture différente.

## Jeux

Les jeux sont tous écrits dans des langages différents, il fallait donc dans un premier temps installer tous les langages et dépendances:

- Java
    - MG2D
- Python
    - pygame
    - librosa
- Love

Il y a fallu corriger des choses pour la plupart des jeux, dont le chemin ```MG2D.geometrie.Couleur``` à chaque fois.

Puis les scripts de lancement des jeux ne fonctionnaient pas pour la plupart.

- Changement de ```python3.7``` par ```python3``` pour chaque jeu python
- Suppression du ```cd projet/[nom-projet]``` et changement de la classe a executer en ajoutant le chemin entier à cause de la ligne ```package ...``` au début des fichiers ```Main.java``` dans certains projets

Le jeu ```Puissance_X``` ne contenait pas de ```photo-small.png``` donc j'en ai rajouté une.

## Automatisation