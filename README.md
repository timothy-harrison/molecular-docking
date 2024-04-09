# Batch Running Vina Autodock w/ Pardaxin Variations made by FoldX

### Assumptions

You have autodock_vina, foldx and open babel installed and in your *PATH*. We also have assumptions based on the rigidity of ligands and receptors.

## Justification

Studying and performing the calculations by hand for 100's, potentially 1000's of different receptor variants is slow and cumbersome. The plan is to eventually get an environment set up so you can simply run:

` calculate ./path_to_ligand ./path_to_receptor ./path_to_output `

And then the program simply takes care of everything else. We arn't at that level yet however, what is in this repository is close.

> Potentially, the plan is to intercept the result to insert into a database for quick and easy reading. There is also potential to package this into a web sever for everyone to access.

## Step 1: Creating a PDB readable by FoldX

Using the shell script:

`foldx --command=PDBFile --pdb=$1
mv PF_basename $1 .pdb.fxout PF_$1`

The first line trandforms the pardaxin pdb into a foldx readable pdb. The second line simply renames it to a pdb (in the next step, foldx won't read the file correctly if it isn't a *.pdb). The `$1` denotes the first argument given, thus we can execute in the terminal: `sh fileName.sh ./pathToPDB`.

The PF at the start distinguishes it from our original pdb.

From this we can then create all the variants of the pdb by running a custom go script called makeVariants. This script takes in the single letter string of your PDB and returns a file readable by foldx to generate all single residue transformations. The code is found in the main.go file (this can be build into a binary and then added to PATH to the be run in the terminal: `makeVariants SINGLELETTERRESIDUE > fileName.txt` to create a file of the residues).

**Note: To create variants you need a rotabase.txt file in the same directory.**

*TODO:* Find a setting to rename the outputted pdbs in to the convention ***residue-residuenumber-finalresidue_pardaxin.pdb*** for example; Gly 1 into Ala: *G1A_pardaxin.pdb*.

## Step 2: Convert the PDBs to PDBQT with Open Babel

With our new pdbs we now need to convert these into pdbqt files for autdock_vina to read.

The first issue is that the PDBs are not in standard PDB format, there are three rows at the start of the file which do not fit the PDB standard. To remedy this we run:

<code>mkdir -p receptors
for p in variants/PF_*.pdb; do
	echo $p
	name=basename $p .pdb
	#echo $name
	grep ATOM $p > variants/${name}_clean.pdb
done

for variant in variants/PF_*_clean.pdb; do
	echo converting $variant
	name=basename $variant .pdb
	obabel $variant --partialcharge gasteiger -O receptors/${name}.pdbqt -xr -xp 
done</code>

This script creates a new location for the variants. It then loops through and copies the correct PDB parts into a new file called name_clean.pdb. Then we look through those files and add gastieger partial charges and output the new receptors into the receptors folder.

## Step 3: Run Vina

<code>#! /bin/bash
mkdir -p output

for l in lipids/*.pdbqt; do
	for f in receptors/*.pdbqt; do 
		echo processing receptor $f and ligand $l 
		ligand_base=basename $l .pdbqt
		receptor_base=basename $f .pdbqt
		output_name="${ligand_base}-${receptor_base}"
		vina --config vina_conf.txt --ligand $l --receptor $f --out output/$output_name.pdbqt
	done
done</code>

Using this script we can loop through the ligands and receptors and dock them using autodock_vina. The results, in pdbqt, form are then output into a different folder called output.

**Note: For vina to work you need a vina_config.txt file in the same directory.**


