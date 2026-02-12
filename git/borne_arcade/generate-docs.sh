#!/bin/bash

# Génération de la structure et des versions des langages
tree -L 1 -F --noreport | grep -v '/$' | sed 's/\*$//' | sed '1d' > docs/structure.md
tree -L 1 -F --noreport | grep '/$' | sed '1d' >> docs/structure.md

python3 --version > docs/env.md
java --version >> docs/env.md
lua -v >> docs/env.md

# -------------------------------
# Script de génération de documentation
# -------------------------------

SITE_DOC="docs/site-doc"
PROJ_DIR="projet"

mkdir -p "$SITE_DOC"

# Vide index.html et démarre le menu
echo "<html><body><h1>Documentation des projets</h1><ul>" > "$SITE_DOC/index.html"

# -------------------------------
# 1️⃣ Doc Java à la racine (menu Borne)
# -------------------------------
BORNE_OUT="$SITE_DOC/borne_menu"
mkdir -p "$BORNE_OUT"

if ls *.java >/dev/null 2>&1; then
    echo "Génération doc pour le menu de la borne (Java)..."
    javadoc -d "$BORNE_OUT" *.java
    echo "<li><a href=\"borne_menu/index.html\">Menu Borne</a></li>" >> "$SITE_DOC/index.html"
fi

# -------------------------------
# 2️⃣ Boucle sur tous les projets
# -------------------------------
for proj in "$PROJ_DIR"/*; do
    [ -d "$proj" ] || continue
    proj_name=$(basename "$proj")
    echo "Traitement du projet $proj_name..."
    
    OUT_DIR="$SITE_DOC/$proj_name"
    mkdir -p "$OUT_DIR"

    # Java ?
    if ls "$proj"/*.java >/dev/null 2>&1; then
        echo "  -> Java"
        javadoc -d "$OUT_DIR" "$proj"/*.java

    # Python ?
    elif ls "$proj"/*.py >/dev/null 2>&1; then
        echo "  -> Python"
        # générer doc avec pdoc
        rm -rf "$OUT_DIR/*"
        pdoc --output-dir "$OUT_DIR $proj"
        echo "$(find $proj -name "*.py")"
    else
        echo "  -> Aucun langage détecté, doc ignorée"
        continue
    fi

    # ajouter au menu
    echo "<li><a href=\"$proj_name/index.html\">$proj_name</a></li>" >> "$SITE_DOC/index.html"
done

# -------------------------------
# 3️⃣ Fermer index.html
# -------------------------------
echo "</ul></body></html>" >> "$SITE_DOC/index.html"

echo "✅ Documentation générée dans $SITE_DOC"
