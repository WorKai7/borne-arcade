import json

def wave(niveau_wave:int) -> list:
    """Fonction permettant de convertir le fichier json et revoie
    la liste des ennemis de la vague
    
    - niveau_wave: entier correspondant au numéro de la vague"""

    with open("data/waves.json", "r") as enemie_fille:
            vague = json.load(enemie_fille)
    list_enemie = []
    for i in range(len(vague[str(niveau_wave)])):
        for y in range(int(vague[str(niveau_wave)][i][2])): 
            list_enemie.append(vague[str(niveau_wave)][i][:2])
    
    return(list_enemie)
