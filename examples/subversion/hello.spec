Name:		hello
Version:	2.5
Release:	1%{?dist}
Summary:	Hello, world from the GNU project.

Group:		SEAS
License:	GPL
URL:		ftp://ftp.gnu.org/gnu/hello/%{name}-%{version}.tar.gz
Source0:	%{name}-%{version}.tar.gz
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

%description
Hello, world from the GNU project.

%prep
%setup -q


%build
%configure
make %{?_smp_mflags}


%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT


%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)

%{_bindir}/hello

%changelog

