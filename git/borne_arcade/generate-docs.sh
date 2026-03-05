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

SITE_DOC="../../docs/technical-docs"
PROJ_DIR="projet"

mkdir -p "$SITE_DOC"

# Vide index.html et démarre le menu avec le nouveau design moderne
cat > "$SITE_DOC/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Documentation Technique - Projets</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            width: 100%;
        }

        .header {
            text-align: center;
            color: white;
            margin-bottom: 60px;
        }

        .header h1 {
            font-size: 3rem;
            margin-bottom: 10px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .header p {
            font-size: 1.2rem;
            opacity: 0.95;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            padding: 20px;
        }

        .menu-card {
            background: white;
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            text-decoration: none;
            color: #333;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            position: relative;
            overflow: hidden;
        }

        .menu-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }

        .menu-card::before {
            content: '';
            position: absolute;
            top: var(--mouse-y, 50%);
            left: var(--mouse-x, 50%);
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(255,255,255,0.4) 0%, transparent 80%);
            transform: translate(-50%, -50%);
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.3s;
        }

        .menu-card:hover::before {
            opacity: 1;
        }

        .card-icon {
            width: 100px;
            height: 100px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }

        .card-icon svg {
            width: 50px;
            height: 50px;
            fill: white;
        }

        .lang-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: bold;
            color: white;
        }

        .lang-badge.java {
            background: #f89820;
        }

        .lang-badge.python {
            background: #3776ab;
        }

        .menu-card h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 10px;
        }

        .menu-card p {
            color: #666;
            line-height: 1.6;
            font-size: 1.1rem;
        }

        .card-footer {
            margin-top: 20px;
            padding: 10px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 30px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .menu-card:hover .card-footer {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .menu-card {
            animation: fadeInUp 0.6s ease forwards;
            opacity: 0;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2rem;
            }
            
            .header p {
                font-size: 1rem;
            }
            
            .menu-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .menu-card {
                padding: 30px 20px;
            }
            
            .menu-card h2 {
                font-size: 1.8rem;
            }
        }

        @media (prefers-color-scheme: dark) {
            .menu-card {
                background: rgba(255,255,255,0.95);
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔧 Documentation Technique</h1>
            <p>Sélectionnez un projet pour voir sa documentation</p>
        </div>
        <div class="menu-grid">
EOF

# -------------------------------
# 1️⃣ Doc Java à la racine (menu Borne)
# -------------------------------
BORNE_OUT="$SITE_DOC/borne_menu"
mkdir -p "$BORNE_OUT"

if ls *.java >/dev/null 2>&1; then
    echo "Génération doc pour le menu de la borne (Java)..."
    javadoc -d "$BORNE_OUT" *.java
    
    # Ajouter la carte Borne au menu avec animation
    cat >> "$SITE_DOC/index.html" << 'EOF'
            <a href="borne_menu/index.html" class="menu-card" style="animation-delay: 0.1s;">
                <span class="lang-badge java">Java</span>
                <div class="card-icon">
                    <svg viewBox="0 0 24 24">
                        <path d="M8 5v14l11-7z"/>
                    </svg>
                </div>
                <h2>Menu Borne</h2>
                <p>Documentation technique de l'interface de la borne interactive</p>
                <div class="card-footer">Voir la doc →</div>
            </a>
EOF
fi

# -------------------------------
# 2️⃣ Boucle sur tous les projets
# -------------------------------
delay=0.2
for proj in "$PROJ_DIR"/*; do
    [ -d "$proj" ] || continue
    proj_name=$(basename "$proj")
    echo "Traitement du projet $proj_name..."
    
    OUT_DIR="$SITE_DOC/$proj_name"
    mkdir -p "$OUT_DIR"

    # Déterminer le langage et l'icône
    if ls "$proj"/*.java >/dev/null 2>&1; then
        echo "  -> Java"
        javadoc -d "$OUT_DIR" "$proj"/*.java
        lang="Java"
        icon="📘"
        lang_class="java"
        
    # Python ?
    # elif ls "$proj"/*.py >/dev/null 2>&1; then
    #     echo "  -> Python"
    #     # générer doc avec pdoc
    #     rm -rf "$OUT_DIR/"*
    #     # Correction: pdoc nécessite un module Python
    #     if command -v pdoc3 >/dev/null 2>&1; then
    #         cd "$PROJ_DIR"
    #         pdoc3 --html --output-dir "$OUT_DIR" "$proj_name"
    #         cd - > /dev/null
    #     elif command -v pdoc >/dev/null 2>&1; then
    #         pdoc --output-dir "$OUT_DIR" "$proj"
    #     else
    #         # Fallback: création d'une doc basique
    #         {
    #             echo "<!DOCTYPE html><html><head><title>$proj_name - Documentation</title>"
    #             echo "<style>body{font-family:Arial;margin:20px;background:#f5f5f5;}</style>"
    #             echo "</head><body><h1>$proj_name</h1><h2>Fichiers Python :</h2><ul>"
    #             for pyfile in "$proj"/*.py; do
    #                 filename=$(basename "$pyfile")
    #                 echo "<li><strong>$filename</strong><pre>"
    #                 cat "$pyfile" | head -50 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
    #                 echo "</pre></li>"
    #             done
    #             echo "</ul></body></html>"
    #         } > "$OUT_DIR/index.html"
    #     fi
    #     lang="Python"
    #     icon="🐍"
    #     lang_class="python"
    else
        echo "  -> Aucun langage détecté, doc ignorée"
        continue
    fi

    # Ajouter la carte du projet au menu avec animation
    cat >> "$SITE_DOC/index.html" << EOF
            <a href="$proj_name/index.html" class="menu-card" style="animation-delay: ${delay}s;">
                <span class="lang-badge $lang_class">$lang</span>
                <div class="card-icon">
                    <svg viewBox="0 0 24 24">
                        <path d="M20 6h-8l-2-2H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V8c0-1.1-.9-2-2-2zm0 12H4V8h16v10z"/>
                    </svg>
                </div>
                <h2>$proj_name</h2>
                <p>Documentation technique du projet $proj_name ($lang)</p>
                <div class="card-footer">Voir la doc →</div>
            </a>
EOF
    
    delay=$(echo "$delay + 0.1" | bc 2>/dev/null || echo "0.3")
    [ -z "$delay" ] && delay=0.3
done

# -------------------------------
# 3️⃣ Fermer index.html
# -------------------------------
cat >> "$SITE_DOC/index.html" << 'EOF'
        </div>
        <div style="text-align: center; margin-top: 40px; color: white; opacity: 0.8;">
            <p>Documentation générée automatiquement • Dernière mise à jour : $(date +%Y-%m-%d)</p>
        </div>
    </div>

    <script>
        // Effet de brillance au survol
        document.querySelectorAll('.menu-card').forEach(card => {
            card.addEventListener('mousemove', (e) => {
                const rect = card.getBoundingClientRect();
                const x = e.clientX - rect.left;
                const y = e.clientY - rect.top;
                
                card.style.setProperty('--mouse-x', `${x}px`);
                card.style.setProperty('--mouse-y', `${y}px`);
            });
        });
    </script>
</body>
</html>
EOF

echo "✅ Documentation technique générée dans $SITE_DOC"
echo "📁 Structure :"
echo "   - $SITE_DOC/index.html (menu principal moderne)"
echo "   - $SITE_DOC/borne_menu/ (documentation Java Borne)"
echo "   - $SITE_DOC/[projets]/ (documentation par projet)"