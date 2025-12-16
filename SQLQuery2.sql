select *
from PortfolioProject1..CovidDeaths$
order by 3,4


--Select data that we are using

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject1..CovidDeaths$
order by 1,2


-- Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract COvid in your country
select location, date, total_cases, total_deaths, (Total_deaths/Total_cases)*100 as Death_Percentage
from PortfolioProject1..CovidDeaths$
where location like '%states%'
order by 1,2


-- Looking at Total Cases Population
-- Shows what percentage of population got Covid

select location, date, Population, total_cases, (Total_deaths/Total_cases)*100 as PercentPopulationInfected
from dbo.CovidDeaths$
where location like '%states%'
order by 1,2




-- Looking at Countries with Highest Infection Rate compared to Population

select location, Population, max(total_cases) as HighestInfectionCount, Max((Total_cases/population))*100 as PercentPopulationInfected
from dbo.CovidDeaths$
where continent is not null
group by location, Population
order by PercentPopulationInfected desc




-- Showing Countries with the highest Death Count per Population


select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from dbo.CovidDeaths$
where continent is not null
group by continent, location
order by TotalDeathCount desc



-- Continent

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from dbo.CovidDeaths$
where continent is not null
group by continent
order by TotalDeathCount desc


--showing Continents with the Highest Death Count per Population

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from dbo.CovidDeaths$
where continent is not null
group by continent
order by TotalDeathCount desc


-- Global Numbers

select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_deaths, sum(cast(new_deaths as int)) / Sum(new_cases)*100 as DeathPercentage
from PortfolioProject1..CovidDeaths$
where continent is not null
--group by date
order by 1,2



-- Total Population vs Vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
--(RollingPeopleVaccinated/population) * 100
from PortfolioProject1..CovidDeaths$ dea
join PortfolioProject1..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3



-- USE CTE

WITH POPvsVAC (Continent, location, date, population, New_vaccinations, RollingPeopleVaccinated) as
( select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject1..CovidDeaths$ dea
join PortfolioProject1..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingPeopleVaccinated/population) * 100
from PopvsVac



-- TEMP Table

drop table if exists #percentPopulationVaccinated
create table #percentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)
insert into #percentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject1..CovidDeaths$ dea
join PortfolioProject1..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null


select *, (RollingPeopleVaccinated/Population) * 100
from #PercentPopulationVaccinated


-- Creating View to Store Data for later visualizations

create View PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject1..CovidDeaths$ dea
join PortfolioProject1..CovidVaccinations$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

select *
from PercentPopulationVaccinated
