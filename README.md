# Basic introduction to Terraform and GitOps for GCP

This guide provides step-by-step instructions for setting up a basic Terraform project using GitOps practices on Google Cloud Platform.

---

## Step 1: File Management

1. **Create a new GitHub repository**  
   Start by setting up a repository where you’ll store and manage your Terraform configuration files.

2. **Navigate to your Terraform working directory**  
   Open your terminal and change into the directory where your Terraform files are or will be stored.

💡 _Note: Your folder structure may differ from the example below._

```bash
cd ~/Documents/TheoWAF/Class6.5/GCP/Terraform/<name-of-repo-that-you-cloned>/
```

## Step 2: Create a Google Cloud Storage Bucket

To proceed, you'll need a Google Cloud Storage bucket. You can either create a new one or use an existing bucket.

-   **Option 1**: [Create a new bucket](https://cloud.google.com/storage/docs/creating-buckets)
-   **Option 2**: Use an existing bucket if one is already available

Once you've selected or created your bucket, **make a note of the bucket name**, as you'll need it in later steps.

## Step 3: Create a Terraform Service Account

You’ll need a Service Account (SA) in Google Cloud for Terraform to authenticate and manage resources.

-   You can **create a new Service Account** with the following roles:

    -   `Editor`
    -   `Artifact Registry Admin`
    -   `Storage Administrator`

-   Alternatively, you can **use an existing Service Account** that already has these roles assigned.

> Only attempt this next step if you don't have a .json key, otherwise go to Step 4
> After creating or identifying the Service Account:

1. **Generate a new JSON key** for the SA and note the filename (e.g., `terraform-sa-key.json`).

2. **Use basic terminal commands** to navigate and move the key file to your Terraform project directory:

    - Check your current directory:

        ```bash
        pwd
        ```

    - List files in your Documents folder:

        ```bash
        ls ~/Documents
        ```

    - Navigate to your Terraform project directory:
        ```bash
        cd ~/Documents/TheoWAF/Class6.5/GCP/Terraform/<name-of-repo-that-you-cloned>/
        ```

Paste the file (once you're sure of the source and destination paths) by:

-   repeating the above steps using basic terminal commands and paste it in the folder destination.

💡 Replace <key-file> with your actual file name and <name-of-repo> with your repository name.

## Step 4: Add a .gitignore File

To prevent sensitive files (such as service account keys) and unnecessary Terraform files from being committed to your repository, download a pre-configured `.gitignore` file.

1. **Download the `.gitignore` file**:

```bash
curl https://raw.githubusercontent.com/thomas065/terraformblues/refs/heads/main/.gitignore -O
```

2. Verify the file

    **Open your project folder in VS Code (or your preferred editor) and confirm that the .gitignore file has been added.**

3. Commit the .gitignore file to your repository (recommended):

```bash
git add .gitignore
git commit -m "Add .gitignore"
git push
```

⚠️ This helps ensure sensitive information like service account keys don't get committed by mistake.

## Step 5: Create an Authentication File

Terraform needs to authenticate with Google Cloud using the service account key you downloaded earlier.

[View authentication file sample](https://github.com/thomas065/terraformblues/blob/main/0-authentication.tf)

1. **Create a file named `0-authentication.tf`** in your project directory. You can do this either by:

    - Using **VS Code** or your preferred editor, or
    - Running the following command in your terminal:

```bash
touch 0-authentication.tf
```

     2. **Add the following content to `0-authentication.tf`**, replacing `<KEY-FILE>.json` with the name of your service account key file:

```hcl
provider "google" {
  credentials = file("<KEY-FILE>.json")
  project     = "<PROJECT-ID>"
  region      = "<SELECTED-REGION>"
}
```

[Google Provider Documentation](https://registry.terraform.io/providers/hashicorp/google/latest)

[Google Provider Reference](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference)

<KEY-FILE>.json: The name of your downloaded service account key file.

<PROJECT-ID>: Your actual Google Cloud project ID.

💡 Save the file, and make sure it is not committed to GitHub if it includes any secrets (but .gitignore should already be handling that).

## Step 6: Set Up a Remote Backend

[View backend file sample](https://github.com/thomas065/terraformblues/blob/main/1-backend.tf)

1. **Create a file named `1-backend.tf`** in your project directory. You can do this by:

-   Using **VS Code** or your preferred editor, or
-   Running the following command in your terminal:

```bash
touch 1-backend.tf
```

2. **Add the following configuration to `1-backend.tf`**:

    ```hcl
    terraform {
     backend "gcs" {
       bucket = "<BUCKET-NAME>"
       prefix = "terraform/state"
     }
    }
    ```

[Hashicorp Developer Documentation on GCS](https://developer.hashicorp.com/terraform/language/backend/gcs)

[Terraform Registry](https://registry.terraform.io/providers/hashicorp/google/latest)

💡 Using a remote backend ensures that your state is securely stored and accessible across different machines or team members.

## Step 7: Create a VPC

Now, you'll create a Virtual Private Cloud (VPC) in Google Cloud. A VPC allows you to define your network structure, including subnets, IP ranges, and firewall rules.

[View VPC file sample](https://github.com/thomas065/terraformblues/blob/main/2-vpc.tf)

1. **Create a file named `2-vpc.tf`** in your project directory. You can do this by:

    - Using **VS Code** or your preferred editor, or
    - Running the following command in your terminal:

```bash
touch 2-vpc.tf
```

2. **Add the following configuration to `2-vpc.tf`** to define your VPC:

```hcl
resource "google_compute_network" "vpc_network" {
    name                    = "my-vpc"
    auto_create_subnetworks = true
}
```

[Terraform Registry](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)

💡 This will create a VPC network with auto-created subnets.

## Step 8: Basic Terraform Workflow

Before applying any changes, ensure Terraform is properly installed and follow the basic workflow steps.

### 1. **Check Terraform Installation**

To verify Terraform is installed, run:

```bash
terraform version
```

### 2. Initialize the Directory

To initialize the current directory for Terraform use, run:

```bash
terraform init
```

> This command will:
> Download the required providers.
> Set up the backend (e.g., remote state storage).
> Prepare the .terraform directory.

### 3. Validate the Configuration

Run the following command to check if your Terraform configuration is syntactically valid:

```bash
terraform validate
```

> This command:
> Validates the configuration without accessing remote providers or backends.
> Is useful for catching typos or configuration issues early.

### 4. Create an Execution Plan

Next, generate a plan for Terraform to execute:

```bash
terraform plan
```

> This command:
> Compares your configuration with the current state.
> Shows what changes Terraform would make (add, update, destroy).
> No actual changes will be made yet.

### 5. Apply the Changes

To apply the proposed changes and provision or update your infrastructure, run:

```bash
terraform apply
```

> This command:
> Prompts for approval before making changes.
> Can be run with the -auto-approve flag to skip the approval prompt and automatically apply the changes.

💡 This basic workflow helps ensure that your Terraform configurations are valid and that changes are planned and applied safely.

### 6. Teardown all VPCs if/when done

To teardown and destroy your infrastructure, run:

```bash
terraform destroy
```

> This command:
> Kills all instances of your VPC network and removes them from GCP.
