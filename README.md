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
mv PF_`basename $1 .pdb`.fxout PF_$1`

The first line trandforms the pardaxin pdb into a foldx readable pdb. The second line simply renames it to a pdb (in the next step, foldx won't read the file correctly if it isn't a *.pdb). The `$1` denotes the first argument given, thus we can execute in the terminal: `sh fileName.sh ./pathToPDB`.

The PF at the start distinguishes it from our original pdb.

From this we can then create all the variants of the pdb by running a custom go script called makeVariants. This script takes in the single letter string of your PDB and returns a file readable by foldx to generate all single residue transformations.

*TODO:* Find a setting to rename the outputted pdbs in to the convention ***residue-residuenumber-finalresidue_pardaxin.pdb*** for example; Gly 1 into Ala: *G1A_pardaxin.pdb*.

## Step 2: Convert the PDBs to PDBQT with Open Babel

With our new pdbs we now need to convert these into pdbqt files for autdock_vina to read.
