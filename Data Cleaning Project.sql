/*

Cleaning Data in SQL Queries

*/


select *
from NashvilleHousing



----------------------------------------------------------------------------------------------------------------------

--- Standardize Date Format

select saledateconverted, convert(date, SaleDate)
from NashvilleHousing


update NashvilleHousing
set SaleDate = convert(date, SaleDate)


ALTER TABLE nashvillehousing
add saledateconverted Date;


update NashvilleHousing
set saledateconverted = convert(date, SaleDate)

----------------------------------------------------------------------------------------------------------------------

--- Populate Property Address Data for null values

select PropertyAddress
from NashvilleHousing
--where PropertyAddress is null
order by ParcelID



select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, isnull(a.propertyaddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null


update a
set PropertyAddress = isnull(a.propertyaddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]




----------------------------------------------------------------------------------------------------------------------

--- Breaking out Address into Individual Columns (Address, City, State)

select PropertyAddress
from NashvilleHousing
--where PropertyAddress is null
--order by ParcelID

Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress)) as Address
from NashvilleHousing



ALTER TABLE nashvillehousing
add PropertySplitAddress Nvarchar(255);


update NashvilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)



ALTER TABLE nashvillehousing
add PropertySplitCity Nvarchar(255);


update NashvilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, len(PropertyAddress))


------------------------------------------

select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
from NashvilleHousing

----- Updating Owner Address -----

ALTER TABLE nashvillehousing
add OwnerSplitAddress Nvarchar(255);

update NashvilleHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)

------------------------------------------

ALTER TABLE nashvillehousing
add OwnerSplitCity Nvarchar(255);

update NashvilleHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)

------------------------------------------

ALTER TABLE nashvillehousing
add OwnerSplitState Nvarchar(255);


update NashvilleHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

------------------------------------------

select PropertySplitAddress, PropertySplitCity,OwnerSplitAddress,OwnerSplitCity, OwnerSplitState
from NashvilleHousing



----------------------------------------------------------------------------------------------------------------------


--- Change Y and N to Yes and No in "Sold as Vacant" field

select distinct(SoldAsVacant), Count(SoldAsvacant)
from NashvilleHousing
group by SoldAsVacant
order by 2




select SoldAsVacant
, CASE When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		else SoldAsVacant
		end
from NashvilleHousing




Update NashvilleHousing
set SoldAsVacant = CASE When SoldAsVacant = 'Y' Then 'Yes'
		When SoldAsVacant = 'N' Then 'No'
		else SoldAsVacant
		end







----------------------------------------------------------------------------------------------------------------------

--- Removing Duplicates Using CTE



With RowNumber as (
select *, 
	ROW_NUMBER() OVER (
	partition by ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				Order by 
					UniqueID
					) row_num

from NashvilleHousing
)
Delete
from RowNumber
where row_num > 1



----------------------------------------------------------------------------------------------------------------------


--- Deleting Unused Columns


select *
from NashvilleHousing



ALTER TABLE NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate



----------------------------------------------------------------------------------------------------------------------



