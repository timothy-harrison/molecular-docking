mkdir -p receptors

for p in variants/PF_*.pdb; do
	echo $p
	name=`basename $p .pdb`
	#echo $name
	grep ATOM $p > variants/${name}_clean.pdb
done

for variant in variants/PF_*_clean.pdb; do
	echo converting $variant
	name=`basename $variant .pdb`
	obabel $variant --partialcharge gasteiger -O receptors/${name}.pdbqt -xr -xp 
done
