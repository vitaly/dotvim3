cat README.index.md >> README.md
cat README.content.md >> README.md
echo README.md >> "$MANIFEST"
rm README.index.md README.content.md
